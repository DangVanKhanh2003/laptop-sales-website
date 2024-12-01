using SellingElectronicWebsite.ViewModel;

namespace SellingElectronicWebsite.Repository
{
    public interface IStatsRepository
    {
        Task<List<StatsViewModel>> GetStats(DateOnly startDate, DateOnly endDate, string unit = "date");
        Task<List<StatsViewModel>> GetStatsByIdCategory(DateOnly startDate, DateOnly endDate, int categoryId, string unit = "date");
    }
}
