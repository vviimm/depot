class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create, :decrement]
  before_action :set_line_item, only: [:show, :edit, :update, :destroy, :decrement]


  # GET /line_items
  def index
    @line_items = LineItem.all
  end

  # GET /line_items/1
  def show
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
  end

  # POST /line_items
  def create
    product = Product.find(params[:product_id])

    @line_item = @cart.add_product(product.id)

    respond_to do |format|
      if @line_item.save
        session[:counter] = 0
        format.html { redirect_to root_url }
        format.js { @current_item = @line_item }
        format.json { render action: 'show',
                      status: :created, location: @line_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @line_item.errors,
                      status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_items/1
  def update
    if @line_item.update(line_item_params)
      redirect_to @line_item, notice: 'Line item was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /line_items/1
  def destroy
    if @line_item.quantity > 1
      @line_item.update_attributes(:quantity => @line_item.quantity - 1)
    else
      @line_item.destroy
    end
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
      format.json { head :no_content }
    end
  end

  def decrement
    @line_item = @cart.decrement_line_item_quantity(params[:id])

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to root_path }
        format.js { @current_item = @line_item }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.js { @current_item = @line_item }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def line_item_params
      params.require(:line_item).permit(:product_id)
    end

end
