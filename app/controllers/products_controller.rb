class ProductsController < ApplicationController
  before_action :authenticate_admin!, only: [:new, :create, :edit, :update, :destroy ]
  # before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :set_category, only: [:index, :show, :new, :edit, :create, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @products = @category.products
    # @quote = Quote.new
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = @category.products.find(params[:id])
    # @quote = Quote.new
  end

  # GET /products/new
  def new
    @product = @category.products.build
  end

  # GET /products/1/edit
  def edit
    @product = @category.products.find(params[:id])
  end

  # POST /products
  # POST /products.json
  def create
    @product = @category.products.build(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to [@product.category, @product], notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    @product = @category.products.find(params[:id])

    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to [@product.category, @product], notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = @category.products.find(params[:id])

    @product.destroy
    respond_to do |format|
      format.html { redirect_to category_products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_category
      @category = Category.find(params[:category_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    # def set_product
    #   @product = @category.products.find(params[:id])
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :category, :price, :image_1, :image_2, :promo)
    end
end