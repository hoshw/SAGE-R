SELECT 
	imp.dma as dma,
	imp.zip_code as zipcode, 
	imp.region as region_name, 
	imp.country as country_name, 
	COUNT(DISTINCT(imp.mm_uuid)) as geo_uu, 
	COUNT(DISTINCT(CASE WHEN evt.pixel_id=$pixel_id_1$ THEN evt.mm_uuid END)) as $pixel_name_1$, 
	COUNT(DISTINCT(CASE WHEN evt.pixel_id=$pixel_id_2$ THEN evt.mm_uuid END)) as $pixel_name_2$, 
	COUNT(DISTINCT(CASE WHEN evt.pixel_id=$pixel_id_3$ THEN evt.mm_uuid END)) as $pixel_name_3$, 
	COUNT(DISTINCT(CASE WHEN evt.pixel_id=$pixel_id_4$ THEN evt.mm_uuid END)) as $pixel_name_4$
FROM 
	(
		SELECT DISTINCT 
			dma,
			zip_code,
			region, 
			country, 
			mm_uuid 
		FROM 
			mm_impressions_$ORG_ID$ 
		WHERE 
			impression_date>="$start_date$"
		AND 
			impression_date<="$end_date$"
		AND 
			lower(country) LIKE "%united states%" 
	) as imp 
LEFT OUTER JOIN 
	(
		SELECT DISTINCT 
			pixel_id, 
			mm_uuid 
		FROM 
			mm_attributed_events_$ORG_ID$ 
		WHERE 
			event_date>="$start_date$"
		AND 
			event_date<="$end_date$"
		AND 
			pixel_id IN ($pixel_id_1$, $pixel_id_2$, $pixel_id_3$, $pixel_id_4$) 
		AND 
			event_type IN ($event_type_conversion$) 
		AND 
			lower(country) LIKE "%united states%" 
	) as evt 
ON 
	imp.mm_uuid=evt.mm_uuid 
GROUP BY 
	imp.dma, 
	imp.zip_code, 
	imp.region, 
	imp.country;