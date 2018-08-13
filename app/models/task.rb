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

	def self.incomplete
  	where(complete: false).order('id DESC')
	end

	def self.complete
  	where(complete: true).order('id DESC')
	end  
	
	def done
		update_attribute(:status, true)
	end	

end