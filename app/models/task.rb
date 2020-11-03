class Task < ApplicationRecord
    def complete?
        return completed_at != nil
    end
end
