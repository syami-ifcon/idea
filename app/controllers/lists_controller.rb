class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]

  # GET /lists
  # GET /lists.json
  def index
    @lists = List.all
  end

  def pure_ajax
    @list = List.find_by(id: params[:id])
    @list.destroy
    respond_to do |format|
        format.js
    end
  end
  # GET /lists/1
  # GET /lists/1.json
  def show

  end

  # GET /lists/new
  def new
    if current_user
      @list = List.new
    else
      redirect_to root_path
    end
  end

  # GET /lists/1/edit
  def edit
    if current_user.id == @list.user.id 
    else
      redirect_to root_path
    end
  end

  # POST /lists
  # POST /lists.json
  def create
    if current_user
      @list = List.new(list_params)
      @list.user_id = current_user.id
      respond_to do |format|
        if @list.save
          format.html { redirect_to @list, notice: 'List was successfully created.' }
        else
          format.html { render :new }
        end
      end
    else
      redirect_to root_path
    end
  end

  # PATCH/PUT /lists/1
  # PATCH/PUT /lists/1.json
  def update
    if current_user.id == @list.user.id
      respond_to do |format|
        @list.user_id = current_user.id
        if @list.update(list_params)
          format.html { redirect_to @list, notice: 'List was successfully updated.' }
          format.json { render :show, status: :ok, location: @list }
        else
          format.html { render :edit }
          format.json { render json: @list.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_path
    end
  end

  def destroy_get
    @list = List.find(params[:list_id])
    if current_user.id == @list.user.id
      @list.destroy
      respond_to do |format|
        format.html { redirect_to lists_url, notice: 'List was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to root_path
    end
  end
  # DELETE /lists/1
  # DELETE /lists/1.json
  def destroy
    if current_user.id == @list.user.id
      @list.destroy
      respond_to do |format|
        format.html { redirect_to lists_url, notice: 'List was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to root_path
    end
  end

  def search
    @lists = List.where("title LIKE ?", "%#{params[:s]}%")
    p @lists
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = List.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def list_params
      params.require(:list).permit(:title, :content, {picture: []})
    end
end
