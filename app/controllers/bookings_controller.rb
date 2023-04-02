class BookingsController < ApplicationController
  def show
    @book = Crud.new(Service).show("id",params[:id])
    @appoint = Crud.new(Appointment).new
    if @book && !@book.slots.nil?
      @slots = @book.slots
    end
  end
  def create
    render plain:params[:appoint][:slot_id]
  end
end
