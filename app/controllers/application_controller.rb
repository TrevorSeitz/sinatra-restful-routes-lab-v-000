class ApplicationController < Sinatra::Base
  require 'pry'

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect '/recipes'
  end

  get '/recipes' do
    @recipe = Recipe.all

    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  get '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])

    erb :show
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  # patch '/recipes/:id' do
  put '/recipes/:id' do
    binding.pry
    # @recipe = Recipe.find(params[:id])
    @recipe = Recipe.find(params[:id])

    @recipe.update(params)
    # [:id], name => params[:name], ingredients => params[:ingredients], cook_time => params[:cook_time])
  #  @recipe.name = params[:name]
  #  @recipe.ingredients = params[:ingredients]
  #  @recipe.cook_time = params[:cook_time]
  #  @recipe.save

    # erb :show
    redirect "/recipes/#{@params[:id]}"
  end

  post '/recipes' do
    # @recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    @recipe = Recipe.create(params)
    redirect "/recipes/#{@recipe.id}"
  end

  delete '/recipes/:id/delete' do
    @recipe = Recipe.find( params[:id])
    @recipe.destroy

    redirect '/recipes'
  end

end
