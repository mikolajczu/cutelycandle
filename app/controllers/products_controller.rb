class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]

  def add_to_cart
    @product = Product.find_by(id: params[:id])
    @cart_item = CartItem.find_or_create_by(product: @product)
    if @cart_item.quantity == nil
      @cart_item.quantity = 0
    end
    @cart_item.quantity += 1
    @cart_item.save
    session[:cart] << @cart_item.id unless session[:cart].include?(@cart_item)
    redirect_to products_path
  end

  # GET /products or /products.json
  def index
    @products = Product.all
  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params.except(:categories))
    create_or_delete_products_categories(@product, params[:product][:categories])

    respond_to do |format|
      if @product.save
        format.html { redirect_to product_url(@product), notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    create_or_delete_products_categories(@product, params[:product][:categories])

    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to product_url(@product), notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.product_categories.destroy_all
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def create_or_delete_products_categories(product, categories)
      product.categories.destroy_all
      categories = categories.strip.split(',')
      categories.each do |cat|
        product.categories << Category.find_or_create_by(name: cat)
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :price, :categories)
    end
end
