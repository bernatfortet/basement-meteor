class @History

	devices: {}

	constructor: ->

		#this.listUsers()

		$("#AppCategoryInput").on "keyup", =>
			this.filter( 'app_category', $("#AppCategoryInput").val() )


		# Possibilites --> FAVORITES, SPACES, AtoZ, RECENT
		$("#OpenedFromInput").on "keyup", =>
			this.filter( 'opened_from', $("#OpenedFromInput").val() )

		name = 'events_70f37d7866964711'
		$.ajax
			dataType: "json",
			url: "devices/#{name}.json",
			success: (deviceData) =>
				this.devices[name] = new Device( item: deviceData )

	listUsers: ->
		for key, deviceData of devicesJSON
			this.devices[key] = new Device( item: deviceData )

	filter: ( filterType, value ) ->
		#console.log filterType, value
		if( value == '' )
			$('.Event').show()
		else
			$('.Event').hide()
			$('.Event['+filterType+'="'+value+'"]').show()