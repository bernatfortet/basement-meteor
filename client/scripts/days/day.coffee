class @Day extends Spine.Controller

	data:
		oppenedApps: 0

	constructor: ( date )->
		super
		this.date = date
		this.render()

	addNewEvent: ( eventData ) ->
		event = new Event( item: eventData )
		this.recordData( event.item )
		this.el.append( event.render() )
		event.setPosition()

		this.refreshData()

	addNewContextEvent: ( eventData ) ->
		contextEvent = new ContextEvent( item: eventData )
		this.el.append( contextEvent.render() )

	render: ->
		source = $("#DayTemplate").html();
		template = Handlebars.compile( source )
		data = 
			date: moment(this.date).format('dddd - LL')

		this.el = $( template( data ) )
		$('#Events').append( this.el )

	recordData: ( eventData ) ->
		this.data.oppenedApps++

	refreshData: ->
		this.el.attr('oppened_apps', this.data.oppenedApps )

