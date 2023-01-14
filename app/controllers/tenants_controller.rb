class TenantsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    
    def index 
        tenants = Tenant.all 
        render json: tenants
    end
    def show  
        tenant = Tenant.find(params[:id])
        render json: tenant, status: :ok
    end
    def create 
        tenant = Tenant.create!(tenant_params)
        render json: tenant, status: :created
   end
   def update 
    tenant = Tenant.find_by(params[:tenant_id])
    tenant.update!(tenant_params)
    render json: tenant, status: :accepted
end

def destroy 
    tenant = Tenant.find_by(params[:tenant_id])
    tenant.destroy
    head :no_content
end
private 
def tenant_params
    params.permit(:name, :age)
end
def record_not_found 
    render json: {error: "not found" }, status: :not_found
end

def record_invalid(invalid)
    render json: {errors: invalid.record.errors.full_messages}, status: 422
end
end
