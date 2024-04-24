// utils.js
const TYPE_FORMATTERS = {
    date: (value, typeAttributes) => {
        return new Intl.DateTimeFormat('en-US', typeAttributes).format(new Date(value));
    }
};

export function formatDateTime(value, type, typeAttributes) {
    if (TYPE_FORMATTERS[type]) {
        return TYPE_FORMATTERS[type](value, typeAttributes);
    }
    return value;
}



