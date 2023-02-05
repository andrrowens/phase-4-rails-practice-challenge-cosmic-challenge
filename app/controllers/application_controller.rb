class ApplicationController < ActionController::API
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_record 

    def invalid_record 
        render json: {error: ["validation errors"]}, status: 400
    end
  
end
