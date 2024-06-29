class UsersController < ApplicationController
    def index
      @users = User.all
      render json: @users
    end
  
    def create
      @user = User.new(user_params)
      if @user.save
        render json: @user, status: :created
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end
  
    def filter
        campaign_names = params[:campaign_names]&.split(',')
        campaign_ids = params[:campaign_ids]&.split(',')

        campaign_ids ||= []
        campaign_ids.compact!

        campaign_names ||= []
        campaign_ids.compact!

        if !campaign_names.empty? && !campaign_ids.empty?
            if campaign_names.length == campaign_ids.length
              json_query = campaign_names.zip(campaign_ids).map do |name, id|
                { "campaign_name": name, "campaign_id": id }
              end.to_json
            else
              render json: { error: "Campaign names and IDs must have the same length" }, status: :unprocessable_entity
              return
            end
        end

        if campaign_ids.empty?
            json_query = campaign_names.map do |name|
                { "campaign_name": name }
            end.to_json
        elsif campaign_names.empty?
            json_query = campaign_ids.map do |id|
                { "campaign_id": id }
            end.to_json
        end
        @users = User.where("JSON_CONTAINS(campaigns_list, ?)", json_query)
        render json: @users
        rescue ActiveRecord::StatementInvalid => e
            Rails.logger.error "ActiveRecord::StatementInvalid: #{e.message}"
            render json: { error: e.message }, status: :unprocessable_entity
    end

    private
  
    def user_params
        params.require(:user).permit(:name, :email, campaigns_list: [:campaign_name, :campaign_id])
    end
  end