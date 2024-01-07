SELECT id
  FROM DATA.LOG_DATA
 WHERE 1=1
  AND event_name = 'category_view'
  -- AND JSON_QUERY(event_property, '$.use_search') = 'used'; 
  AND JSON_EXTRACT_SCALAR(event_property,'$.use_search')='used';
