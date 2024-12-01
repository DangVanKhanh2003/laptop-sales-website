using AutoMapper;
using Microsoft.EntityFrameworkCore;
using SellingElectronicWebsite.Entities;
using SellingElectronicWebsite.ViewModel;

namespace SellingElectronicWebsite.Repository
{
    public class StatsRepository : IStatsRepository
    {

        private SellingElectronicsContext _context;
        private readonly IMapper _mapper;


        public StatsRepository(SellingElectronicsContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;

        }

        public async Task<List<StatsViewModel>> GetStats(DateOnly startDate, DateOnly endDate, string unit = "date")
        {
            // get all order between start date and end date
            var orders = await _context.ProductOrders
                                            .Include(o => o.Order)
                                            .Where(o => o.Order.Status.ToLower() == "approve" 
                                                                                    && DateOnly.FromDateTime((DateTime)o.Order.DateExport) > startDate 
                                                                                    && DateOnly.FromDateTime((DateTime)o.Order.DateExport) < endDate)
                                            .Select(o => new {
                                                                                time = DateOnly.FromDateTime((DateTime)o.Order.DateExport),
                                                                                amount = o.Amount,
                                                                                money = o.Amount * o.UntilPrice
                                            })
                                            .ToListAsync();
            // group by unit
            List<StatsViewModel> listUnit = new List<StatsViewModel>();
            switch (unit)
            {
                case "date":
                    listUnit = orders.GroupBy(o => o.time)
                                      .Select(group => new StatsViewModel
                                      {
                                          year = group.Key.Year,
                                          month = group.Key.Month,
                                          date = group.Key.Day,
                                          amount = group.Sum(item => item.amount),
                                          money = group.Sum(item => item.money)
                                      })
                                    .ToList();
                    break;
                case "month":
                    listUnit = orders.GroupBy(o => new { o.time.Year, o.time.Month })
                                      .Select(group => new StatsViewModel
                                      {
                                          year = group.Key.Year,
                                          month = group.Key.Month,
                                          amount = group.Sum(item => item.amount),
                                          money = group.Sum(item => item.money)
                                      })
                                      .ToList() ;
                    break;
                case "year":
                    listUnit = orders.GroupBy(o => o.time.Year)
                                        .Select(group => new StatsViewModel
                                        {
                                            year = group.Key,
                                            amount = group.Sum(item => item.amount),
                                            money = group.Sum(item => item.money)
                                        })
                                        .ToList();
                    break;
            }

            return listUnit;
        }

        public async Task<List<StatsViewModel>> GetStatsByIdCategory(DateOnly startDate, DateOnly endDate, int categoryId, string unit = "date")
        {
            // get all order between start date and end date
            var orders = await _context.ProductOrders
                                            .Include(o => o.Order)
                                            .Include(o => o.Product.Category)
                                            .Where(o => o.Order.Status.ToLower() == "approve"
                                                        && o.Product.CategoryId == categoryId
                                                        && DateOnly.FromDateTime((DateTime)o.Order.DateExport) > startDate
                                                        && DateOnly.FromDateTime((DateTime)o.Order.DateExport) < endDate)
                                            .Select(o => new {
                                                time = DateOnly.FromDateTime((DateTime)o.Order.DateExport),
                                                amount = o.Amount,
                                                money = o.Amount * o.UntilPrice
                                            })
                                            .ToListAsync();
            // group by unit
            List<StatsViewModel> listUnit = new List<StatsViewModel>();
            switch (unit)
            {
                case "date":
                    listUnit = orders.GroupBy(o => o.time)
                                      .Select(group => new StatsViewModel
                                      {
                                          year = group.Key.Year,
                                          month = group.Key.Month,
                                          date = group.Key.Day,
                                          amount = group.Sum(item => item.amount),
                                          money = group.Sum(item => item.money)
                                      })
                                    .ToList();
                    break;
                case "month":
                    listUnit = orders.GroupBy(o => new { o.time.Year, o.time.Month })
                                      .Select(group => new StatsViewModel
                                      {
                                          year = group.Key.Year,
                                          month = group.Key.Month,
                                          amount = group.Sum(item => item.amount),
                                          money = group.Sum(item => item.money)
                                      })
                                      .ToList();
                    break;
                case "year":
                    listUnit = orders.GroupBy(o => o.time.Year)
                                        .Select(group => new StatsViewModel
                                        {
                                            year = group.Key,
                                            amount = group.Sum(item => item.amount),
                                            money = group.Sum(item => item.money)
                                        })
                                        .ToList();
                    break;
            }
            return listUnit;

        }

       
    }
}
