function returnedValue = LimitFunc(value, limit)
%LimitFunc returns the value if it is less than limit otherwise returns the
%limit

if(value >= limit)
    returnedValue = limit;
else
    returnedValue = value;
end
    
end

