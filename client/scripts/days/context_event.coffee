class @ContextEvent extends Spine.Controller


	time: null

	constructor: ->
		super
		this.time = new Date( this.item.time )
		console.log this.item.space_name

	render: () ->
		source = $("#ContextEventTemplate").html();
		template = Handlebars.compile( source )
		this.el = $( template( this.item ) )
		this.setPosition()

	setPosition: ->
		this.el.css('left', this.getDayTimePercentage( this.time ) + '%' )
		#this.el.css('top', this.getHourTimePercentage( this.time ) + '%' )


	getDayTimePercentage: ( date ) ->
		minutesInDay = 1440
		numberOfHours = date.getHours()
		numberOfMinutes = date.getMinutes()
		totalNumberOfMinutes = numberOfHours * 60 + numberOfMinutes
		return totalNumberOfMinutes * 100 / minutesInDay 