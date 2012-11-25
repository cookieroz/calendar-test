module CalendarHelper

  def calendar(date = Date.today, &block)
    Calendar.new(self, date, block).table
  end

  class Calendar < Struct.new(:view, :date, :callback)
    HEADER = %w[Sun Mon Tue Wed Thu Fri Sat]
    START_DAY = :sunday

    delegate :content_tag, to: :view

    def year
      content_tag :div, class: "calendar" do
        month_tables
      end
    end

    def month_tables
      months.map do
        content_tag :table, class: "calendar" do
         [header + week_rows].join.html_safe
        end
      end
    end

    def table
      content_tag :table, class: "calendar" do
        header + week_rows
      end
    end

    def header
      content_tag :tr do
        HEADER.map { |day| content_tag :th, day }.join.html_safe
      end
    end

    def week_rows
      first = date.beginning_of_month.beginning_of_week(START_DAY)
      revs = Reservation.where("start_date > ?", first).map { |reserv| {s: reserv.start_date,e: reserv.due_date } }

      weeks.map do |week|
        content_tag :tr do
          week.map { |day| day_cell(day, revs) }.join.html_safe
        end
      end.join.html_safe
    end

    def day_cell(day, revs)
      content_tag :td, view.capture(day, &callback), class: day_classes(day, revs)
    end

    # @param [Object] day
    def day_classes(day, revs)
      classes = []
      classes << "today" if day == Date.today
      classes << "notmonth" if day.month != date.month
      reserved = false
      revs.each do |r|
        if day > r[:s] && day < r[:e]
          reserved = true
        end
      end
      classes << "reserved" if reserved
      classes.empty? ? nil : classes.join(" ")
    end

    def weeks
      first = date.beginning_of_month.beginning_of_week(START_DAY)
      last = date.end_of_month.end_of_week(START_DAY)
      (first..last).to_a.in_groups_of(7)
    end

    def months
      first_month = date.beginning_of_year.beginning_of_month
      last_month = date.end_of_year.end_of_month
      (first_month..last_month).to_a.html_safe
    end
  end
end