using SellingElectronicWebsite.Entities;

namespace SellingElectronicWebsite.Helper
{
    public class PaginatedList<T>: List<T>
    {
        public int PageIndex { get; set; } 
        public int TotalPage { get; set; }

        public PaginatedList(List<T> items, int count, int pageIndex, int pageSize)
        {
            pageIndex = pageIndex;
            TotalPage = (int)Math.Ceiling((double)count / (double)pageSize);
            AddRange(items);
        }

        public static PaginatedList<T> create(IQueryable<T> source, int pageIndex, int pageSize)
        {

            var count = source.Count();
            var items = source.Skip((pageIndex - 1) * pageSize).Take(pageSize).ToList();
            return new PaginatedList<T>(items, count, pageIndex, pageSize);
        }

    }
}
