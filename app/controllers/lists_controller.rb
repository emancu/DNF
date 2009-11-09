class ListsController < ApplicationController
  before_filter :require_user

  def index
  end

  def new
    @list = current_user.lists.new
  end

  def create
    @list = current_user.lists.new(params[:list])
    if @list.save
      flash[:notice] = "New list created!"
      redirect_back_or_default list_path(@list)
    else
      render :action => :new
    end
  end

  def show
    @list = List.find(params[:id])
  end

  def edit
    @list = List.find(params[:id])
  end

  def update
    @list = List.find(params[:id])
    if @list.update_attributes(params[:list])
      flash[:notice] = "List successfuly updated!"
      redirect_to lists_path()
    else
      render :action => :edit
    end
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy

    respond_to do |format|
      format.html { redirect_to(:back) }
      format.xml  { head :ok }
    end
  end

end


