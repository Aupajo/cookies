class EntriesController < ApplicationController
  before_filter :find_questionnaire
  helper_method :completed_form?
  
  def index
    if completed_form?
      render 'success'
    elsif @questionnaire.open?
      @entry = @questionnaire.entries.build
    else
      render 'desolate'
    end
  end
  
  def create
    @entry = @questionnaire.entries.build(params[:entry])
    
    if @entry.save
      complete_form!
      render 'success'
    else
      render 'index'
    end
  end
  
  private
  
  def find_questionnaire
    @questionnaire = Questionnaire.last
  end
  
  def completed_form?
    cookies[questionnaire_cookie_name].present?
  end
  
  def complete_form!
    cookies.permanent[questionnaire_cookie_name] = true
  end
  
  def questionnaire_cookie_name
    'questionnaire:' + @questionnaire.id.to_s
  end
end