// formatter.resource - JavaScript para formata��o
window.myFormatter = {
    formatCurrency: function(value) {
        if (value === null || value === undefined) return '';
        return new Intl.NumberFormat('pt-BR', { style: 'currency', currency: 'BRL' }).format(value);
    },
    formatDate: function(dateString) {
        if (!dateString) return '';
        const options = { year: 'numeric', month: '2-digit', day: '2-digit' };
        return new Date(dateString).toLocaleDateString('pt-BR', options);
    },
    formatTime: function(timeString) {
        if (!timeString) return '';
        const parts = timeString.split(':');
        if (parts.length >= 2) {
            return `${parts[0]}:${parts[1]}`;
        }
        return timeString;
    }
};
