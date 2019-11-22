`/temperature/`: Temperature endpoint

`/temperature/loc_id`: Most recent temperature for the location having id

`/temperature/loc_id/?date=instant`: Temperature for the location loc_id at the instant instant

`/temperature/loc_id/?date=debut,fin`: temperature for the id at the time debut and fin

`/temperature/all/?date=debut,fin`: The temperatures of all the sensors between the dates debut and fin.

`/temperature/all/?date=instant`: The temperature of all sensors at the instant instant.

`/temperature/all`: The most recent temperature of all the sensors

Return type

```json
{
    "loc_id":id,
    "data": {
        "unit": "unit-of-measure",
        "time": yyyy-mmm-dd,
        "value": xx.x
    }
}
```