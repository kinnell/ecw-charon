class ServiceQueuesController < ApplicationController
  def index
    @service_queues = ServiceQueue.all
  end
end
