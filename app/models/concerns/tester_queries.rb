module TesterQueries
  extend ActiveSupport::Concern

  included do
    scope :not_trashed, -> { where(trashed_at: nil) }
    scope :trashed, -> { where.not(trashed_at: nil) }
    scope :not_onstage, -> { where.not(location: "Onstage") }
    scope :onstage, -> { where(location: "Onstage") }
  end

  class_methods do
    def current_shop(employee)
      where(shop_id: employee.shop_id)
    end
    
    def all_testers_backstage(employee)
      current_shop(employee).not_trashed.not_onstage.order(created_at: "DESC")
    end
    
    def by_department(employee, department_name)
      department = Department.find_by(name: department_name)
      current_shop(employee).not_trashed.not_onstage.where(
        product_id: Product.where(department_id: department.id).pluck(:id)
      ).order(created_at: "DESC")
    end

    def trashed_at_shop(employee)
      current_shop(employee).trashed.order(trashed_at: "DESC")
    end

    def monthly_trashed_testers(employee)
      start_of_month = Time.current.beginning_of_month
      end_of_month = Time.current.end_of_month

      joins(:product)
      .current_shop(employee)
      .where.not(trashed_at: nil)
      .where(trashed_at: start_of_month..end_of_month)
      .group("products.name")
      .count
    end

    def yearly_trashed_testers(employee)
      start_of_year = Time.current.beginning_of_year
      end_of_year = Time.current.end_of_year

      joins(:product)
      .current_shop(employee)
      .where.not(trashed_at: nil) 
      .where(trashed_at: start_of_year..end_of_year) 
      .group_by_month("trashed_at", format: "%b %Y")
      .count
    end
    
    def onstage_not_trashed(employee)
      current_shop(employee).onstage.not_trashed.order(created_at: "DESC")
    end

    def backstage_not_trashed(employee)
      current_shop(employee).not_onstage.not_trashed.order(created_at: "DESC")
    end
  end
end
