class MissionsController < ApplicationController

    def create 
        mission = Mission.create!(mission_params)
        if mission 
            render json: mission, status: :created 
        else
            render json: {error: ["validation errors"]}, status: :not_found
        end
    end

    private 

    def mission_params
        params.permit(:name, :scientist_id, :planet_id)
    end

end
