class @Device extends Spine.Controller

	currentDay: null
	renderLimit: 0

	constructor: ->
		super

		this.buildInfo()

		#$('.Event .icon').on('click', this.onClickEvent )
		#$('.Events').on('click', this.onClickEvents )
		$('.Event .icon').on('mouseover', this.onMouseOver )
		$('.Event .icon').on('mouseout', this.onMouseOut )

	buildInfo: ->
		this.lastEventTime = 0
		counter = 0

		for key, eventData of this.item

			# Stop rendering events if limit is reached
			if( this.renderLimit != 0 && counter > this.renderLimit )
				return

			# Build Opened App event
			switch eventData.type
				when 'App_Opened'
					this.buildOppenedAppEvent( eventData )
					counter++

				when 'Context_Triggered'
					this.buildContextTriggeredEvent( eventData )
					counter++
			

	buildOppenedAppEvent: (eventData) ->
		eventDate = new Date( eventData.time )

		# Render a new Day if event is in new day
		if( this.eventIsInNewDay( eventDate ) )
			this.currentDay = new Day( eventDate )			

		this.currentDay.addNewEvent( eventData )

		this.lastEventTime = eventDate.getTime()

	buildContextTriggeredEvent: (eventData) ->
		this.currentDay.addNewContextEvent( eventData )


	eventIsInNewDay: ( eventDate ) ->
		#console.log 'eventDate.getTime() -- ', eventDate.getTime()
		#console.log 'this.lastEventTime-- ', this.lastEventTime
		minimumHoursForNewDay = 5
		return ( eventDate.getTime() - this.lastEventTime ) / 3600 / 1000 > minimumHoursForNewDay
	


	### EVENTS ##########################




	onClickEvent: ( event ) ->
		eventAppName = $(event.currentTarget).closest('.Event').attr('package_name')
		$('.Event ').attr( 'state', 'Hidden')
		$('.Event[package_name="'+eventAppName+'"]').attr( 'state', 'Active')




	onMouseOver: ( event ) ->
		eventAppName = $(event.currentTarget).closest('.Event').attr('package_name')
		$('.Event ').attr( 'state', 'Hidden')
		$('.Event[package_name="'+eventAppName+'"]').attr( 'state', 'Active')


	onClickEvents: ( event ) ->
		$('.Event').attr( 'state', '')

	onMouseOut: ( event ) ->
		$('.Event').attr( 'state', '')