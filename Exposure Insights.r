CREATE TMP TABLE tmp_site AS
SELECT	
	(CASE WHEN AE.pixel_id = '$PIXEL_1_ID$' THEN 1 ELSE 0 END) AS  $PIXEL_1_NAME$,
	(CASE WHEN AE.pixel_id = '$PIXEL_2_ID$' THEN 1 ELSE 0 END) AS  $PIXEL_2_NAME$,
	(CASE WHEN AE.pixel_id = '$PIXEL_3_ID$' THEN 1 ELSE 0 END) AS  $PIXEL_3_NAME$,
	(CASE WHEN AE.pixel_id = '$PIXEL_4_ID$' THEN 1 ELSE 0 END) AS  $PIXEL_4_NAME$,
	AE.mm_uuid
FROM 
	mm_attributed_events_$ORG_ID$ AE 
where 
	AE.event_date BETWEEN '$START_DATE$' and '$END_DATE$';

SELECT 
	COUNT(mm_uuid) AS site_uu,
	$PIXEL_1_NAME$,
	$PIXEL_2_NAME$,
	$PIXEL_3_NAME$,
	$PIXEL_4_NAME$
FROM 
	tmp_site 	
group by
	$PIXEL_1_NAME$,
	$PIXEL_2_NAME$,
	$PIXEL_3_NAME$,
	$PIXEL_4_NAME$