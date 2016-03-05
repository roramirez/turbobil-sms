class ListsController < ApplicationController

  layout "customer"
  before_filter :authenticate_customer!
  before_action :set_list, only: [:show, :edit, :update, :destroy, :import, :upload, :import_map]

  # GET /lists
  # GET /lists.json
  def index
    @lists = current_customer.lists
                              .page(params[:page]).per(10)
                              .sorted(params[:sort])
  end

  # GET /lists/1
  # GET /lists/1.json
  def show
  end

  # GET /lists/new
  def new
    @list = List.new
  end

  # GET /lists/1/edit
  def edit
  end

  # POST /lists
  # POST /lists.json
  def create
    @list = List.new(list_params)
    default_column @list

    current_customer.lists << @list

    respond_to do |format|
      if @list.save
        format.html { redirect_to  import_list_path(@list), notice: 'List was successfully created.' }
        format.json { render :show, status: :created, location: @list }
      else
        format.html { render :new }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lists/1
  # PATCH/PUT /lists/1.json
  def update
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to lists_path, notice: 'List was successfully updated.' }
        format.json { render :show, status: :ok, location: @list }
      else
        format.html { render :edit }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1
  # DELETE /lists/1.json
  def destroy
    @list.destroy
    respond_to do |format|
      format.html { redirect_to lists_url, notice: 'List was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  # upload contact
  def import
  end

  def upload
    @key = SecureRandom.hex(64)
    @list.import(params[:file], @key)
    @temp_contacts = TmpContactList.get_by_key_and_list(@key, @list)
  end

  def import_map
    @temp_contacts = TmpContactList.get_by_key_and_list(params[:key], @list, nil)
    key_map = @list.column_list.key_map.id
    key_index = nil
    columns_map = params[:columns]

    columns_map.each_with_index do |c, i|
      if c.to_i == key_map
        key_index = i
      end
    end

    @temp_contacts.each do |tmp|
      contact =  Contact.new
      contact.list = @list
      number = tmp.content[key_index].to_s

      #hast map column with column_list
      h = columns_map.each_with_index.map { |x,i| [x, tmp.content[i]] }
      hash_data = Hash[h]
      contact.data = hash_data

      if number.chr != '+'
        number = '+' + number
      end

      if number_int = GlobalPhone.parse(number)
        contact.number = number_int.international_string

        if params[:ignore_exist] == 'true'
          exists = false
        else
          exists = Contact.exist_number_on_list(contact.number.to_s, @list)
        end

        if exists == false
          contact.save
        end
      end

    end

    render :import_map, status: :ok, location: @list
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = current_customer.lists.find(params[:id])
    end

    def default_column list
    # add default column
      columns = [:Name, :Number]
      columns.each do |n|
        c = ColumnList.new
        c.name = n
        c.list = list
        if n == :Number
          c.key = true
        end
        c.save
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def list_params
      params.require(:list).permit(:name)

    end
end
