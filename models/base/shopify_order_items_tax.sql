select

	_sdc_level_0_id,
	_sdc_level_1_id,
	price,
	rate,
	title

from
  	{{var('items_tax_table')}}