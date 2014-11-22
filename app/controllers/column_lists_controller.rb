class ColumnListsController < ApplicationController
  before_filter :authenticate_customer!
  before_action :set_column_list, only: [:show, :edit, :update, :destroy]
  before_action :set_list, only: [:show, :edit, :update, :destroy, :new, :create, :index]

  # GET /column_lists
  # GET /column_lists.json
  def index
    @column_lists = @list.column_list
  end

  # GET /column_lists/1
  # GET /column_lists/1.json
  def show
  end

  # GET /column_lists/new
  def new
    @column_list = @list.column_list.new
  end

  # GET /column_lists/1/edit
  def edit
  end

  # POST /column_lists
  # POST /column_lists.json
  def create
    @column_list = @list.column_list.new(column_list_params)

    respond_to do |format|
      if @column_list.save
        format.html { redirect_to  list_column_lists_path(@list), notice: 'Column list was successfully created.' }
        format.json { render :show, status: :created, location:  list_column_list_path(@list, @column_list) }
      else
        format.html { render :new }
        format.json { render json: @column_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /column_lists/1
  # PATCH/PUT /column_lists/1.json
  def update
    respond_to do |format|
      if @column_list.update(column_list_params)
        format.html { redirect_to  list_column_list_path(@column_list), notice: 'Column list was successfully updated.' }
        format.json { render :show, status: :ok, location: list_column_list_path(@column_list) }
      else
        format.html { render :edit }
        format.json { render json: @column_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /column_lists/1
  # DELETE /column_lists/1.json
  def destroy
    @column_list.destroy
    respond_to do |format|
      format.html { redirect_to column_lists_url, notice: 'Column list was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = current_customer.lists.find(params[:list_id])
    end
    def set_column_list
      @column_list = @list.column_list.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def column_list_params
      params.require(:column_list).permit(:name)
    end
end
