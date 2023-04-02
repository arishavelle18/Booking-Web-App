class Crud
    def initialize(model)
        @model = model
    end

    def index()
         @model.all
    end

    def new(params=nil)
         params.nil? ? @model.new : @model.new(params)
    end

    def show(column,data)
        @model.find_by(column => data)
    end

    def create
       @model.save()
    end

    def update
        @model.update
    end

    def dataAssoc(child)
        @model.send(child)
    end

    def redirect(path,option={})
        redirect_to path , options 
    end
end