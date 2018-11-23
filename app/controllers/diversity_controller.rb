class DiversityController < ApplicationController
  def index
    @people = DiversityBoardMember.all.order(position: :asc)

    set_meta_tags title: 'Diversity & Inclusion | Recruit Talent In The Finance Sector',
                  description: 'ENSURING AN EQUAL OPPORTUNITY FOR EVERYONE',
                  og: {
                    title: 'Diversity & Inclusion | Recruit Talent In The Finance Sector'
                  }
  end
end
