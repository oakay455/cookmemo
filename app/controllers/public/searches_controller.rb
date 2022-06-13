class Public::SearchesController < ApplicationController

  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]
    if @model == 'member'
      @records = Member.search_for(@content, @method)
    else
      @records = Recipe.search_for(@content, @method)
    end
  end
end
