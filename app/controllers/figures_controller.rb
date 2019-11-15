class FiguresController < ApplicationController
  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end
  
  get '/figures/new' do
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'figures/new'
  end
  
  post '/figures' do
    @figure = Figure.create(params["figure"])
    if !params["title"].empty?
      title = Title.create(params["title"])
      @figure.titles << title
    end
    if !params["landmark"].empty?
      landmark = Landmark.create(params["landmark"])
      @figure.landmarks << landmark
    end
    
    @figure.save
    redirect "/figures/#{@figure.id}"
  end
  
  get '/figures/:id' do
    @figure = Figure.find(params["id"])
    erb :'figures/show'
  end
  
  get '/figures/:id/edit' do
    @landmarks = Landmark.all
    @titles = Title.all
    @figure = Figure.find(params["id"])
    erb :'figures/edit'
  end
  
  patch '/figures/:id' do
    @figure = Figure.find(params["id"])
    @figure.update(params["figure"])
    if !params["title"].empty?
      title = Title.create(params["title"])
      @figure.titles << title
    end
    if !params["landmark"].empty?
      landmark = Landmark.create(params["landmark"])
      @figure.landmarks << landmark
    end
    
    @figure.save
    redirect "/figures/#{@figure.id}"
  end
end
