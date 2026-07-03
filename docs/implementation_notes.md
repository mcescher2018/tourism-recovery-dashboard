# Implementation Notes

This section outlines key implementation decisions, trade-offs, and deviations from the original project template.

## Headline Card

The headline card represents Italy as a whole and therefore must remain unaffected by slicer interactions. Since Power BI does not natively support mixing global and slicer-dependent visuals within the same context, a fixed DAX measure was used:

```DAX
CALCULATE(
    [Recovery_Index],
    REMOVEFILTERS(dim_region[region_name])
)
```

This ensures the national Recovery Index remains constant regardless of regional filters.

## Region Bar Chart

In the dataset, all regional Recovery Index values were above 1. As a result, a uniform conditional coloring would not provide meaningful differentiation.

To improve interpretability, a custom color scale was applied:

- Red: Index < 1  
- Yellow: 1 ≤ Index < 1.1  
- Light Blue: 1.1 ≤ Index < 1.3  
- Blue: Index ≥ 1.3  

## Line Chart

Since monthly granularity was not available in the dataset, a simplified yearly line chart was selected, using Year as the x-axis and Recovery Index as the measure.

Additionally, forecasting was added to extend the trend beyond 2025.

## Forecasting

A built-in Exponential Smoothing (ETS) forecasting model from Power BI was used, with seasonality disabled. 

Given the limited time series length and granularity, the following simplified configuration was applied:

- Forecast horizon: 3 years  
- Confidence interval: 75%  

No advanced forecasting models were applied due to data constraints.