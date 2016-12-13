class PinsController < ApplicationController
	before_action :find_pin, only: [:show, :edit, :update, :destroy, :upvote]
	before_action :authenticate_user!, except: [:index, :show]


	def index
		@pins = Pin.all.order("created_at DESC")
	end

	def show

	end

	def new 
		@pin = current_user.pins.build
	end

	def create
		@pin = current_user.pins.build(pin_params)
		if @pin.save
			redirect_to @pin, notice: "Successfuly created new pin"
		else
			render "new"
		end
	end

	def edit

	end

	def update
		if @pin.update(pin_params)
			redirect_to @pin, notice: "Successfuly edited pin"
		else
			render "edit"
		end
	end

	def destroy
		@pin.destroy
		redirect_to root_path, notice: "Successfuly deleted pin"
	end

	def upvote
		@pin.liked_by current_user
		respond_to do |format|
			format.js
		end
	end

	private

		def pin_params
			params.require(:pin).permit(:image, :title, :content)
		end

		def find_pin
			@pin = Pin.find(params[:id])
		end
end
