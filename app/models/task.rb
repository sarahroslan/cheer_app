class Task < ApplicationRecord
	belongs_to :user

	validates :title, presence: true


	def self.search(term)
	  if term
	    where('title LIKE ?', "%#{term}%").order('id DESC') || where('description LIKE ?', "%#{term}%").order('id DESC')
	  else
	    order('id DESC') 
	  end
	end


	
end