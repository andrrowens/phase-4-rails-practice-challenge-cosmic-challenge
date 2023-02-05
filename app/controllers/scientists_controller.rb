class ScientistsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_record 

    def index
        scientists = Scientist.all 
        render json: scientists, except: [:created_at, :updated_at], status: :ok
    end

    def show
        scientist = Scientist.find_by(id: params[:id])
        if scientist
            render json: scientist, except: [:created_at, :updated_at], include: :planets, status: :ok
        else
            render json: {error: "Scientist not found"}, status: :not_found
        end
    end

    def create
        scientist = Scientist.create!(scientist_params)
        if scientist 
            render json: scientist, status: :created
        else 
            render json: {error: ["validation errors"]}, status: :not_found
        end
    end

    def update 
        scientist = Scientist.find_by(id: params[:id])
        if scientist 
            scientist.update!(scientist_params)
            render json: scientist, status: :accepted
        else 
            render json: {error: ["validation errors"]}, status: :not_found
        end
    end

    def destroy 
        scientist = Scientist.find_by(id: params[:id])
        scientist.destroy 
        head :no_content

    end


    private 

    def scientist_params 
        params.permit(:name, :field_of_study, :avatar)
    end

    def not_found 
        render json: {error: "Scientist not found"}, status: 400
    end 

    def invalid_record 
        render json: {error: ["validation errors"]}, status: 400
    end
    
end
