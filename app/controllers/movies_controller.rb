class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    if(!params[:ratings].nil?)
      @checkstate=params[:ratings].keys
      qstring=String.new
      index=1
      @checkstate.each{|box| qstring =qstring+"rating='#{box}'";if(index<@checkstate.length) then qstring=qstring+" or " end;index=index+1}
      @sort_key = params[:sort_by]
      @movies=Movie.find(:all,:conditions=>[qstring],:order=>@sort_key)
    else
      @movies = Movie.order(params[:sort_by])
      @sort_key = params[:sort_by]
      @checkstate=Array.new
    end
    @header_style={:title=>((params[:sort_by]=='title')? "hilite": ""), :release_date=>((params[:sort_by]=='release_date')? "hilite":"")}
    @all_ratings=Movie.ratings
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
