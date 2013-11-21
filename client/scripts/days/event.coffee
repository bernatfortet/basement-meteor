class @Event extends Spine.Controller


	time: null

	constructor: ->
		super
		this.item.clean_package_name = this.getCleanPackageName( this.item.package_name )
		this.time = new Date( this.item.time )
		this.item.timeHour = moment( this.item.time).format( 'HH:mm')

	render: () ->
		source = $("#EventTemplate").html();
		template = Handlebars.compile( source )
		this.el = $( template( this.item ) )

		if( this.item.categories )
			this.el.attr('app_category', this.item.categories[0] )

	setPosition: ->
		this.el.css('left', this.getDayTimePercentage( this.time ) + '%' )	
		this.el.css('top', this.getHourTimePercentage( this.time ) + '%' )


	getCleanPackageName: ( fullName ) ->
		appName = fullName.split('.')
		appName = appName[ appName.length - 1 ]
		return capitalizedName = appName.charAt(0).toUpperCase() + appName.slice(1);

	getDayTimePercentage: ( date ) ->
		minutesInDay = 1440
		numberOfHours = date.getHours()
		numberOfMinutes = date.getMinutes()
		totalNumberOfMinutes = numberOfHours * 60 + numberOfMinutes
		return totalNumberOfMinutes * 100 / minutesInDay 


	getHourTimePercentage: ( date ) ->
		secondsInHour = 60 * 60
		numberOfMinutes = date.getMinutes()
		numberOfSeconds = date.getSeconds()
		totalNumberOfSeconds = numberOfMinutes * 60 + numberOfSeconds
		return totalNumberOfSeconds * 100 / secondsInHour 