class OutgoingsController < ApplicationController

  layout "customer"
  before_filter :authenticate_customer!
  before_action :set_outgoing, only: [:show]

  # GET /outgoings
  # GET /outgoings.json
  def index
    @outgoings = current_customer.outgoings
                              .page(params[:page]).per(10)
                              .sorted(params[:sort])
                              .filter(params.slice(:campaign))


    respond_to do |format|
      format.html
      format.csv { render text: current_customer.outgoings.filter(params.slice(:campaign)).to_csv }
    end

  end


  # GET /outgoings/1
  # GET /outgoings/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_outgoing
      @outgoing = current_customer.outgoings.find(params[:id])
    end

end
