class ApplicationController < Sinatra::Base
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

  post '/recipes/:id' do
    @recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
# binding.pry
    redirect "/recipes/#{@recipe.id}"
  end

  get '/recipes/:id' do
    @recipe = Recipe.find_by(id: params[:id])

    erb :show
  end



  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
# binding.pry
    erb :edit
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find(params[:id])

    @recipe.update(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])

    erb :show
  end

  delete '/recipes/:id/delete' do
    @recipe = Recipe.find( params[:id])
    @recipe.destroy

    redirect '/recipes'
  end

end
