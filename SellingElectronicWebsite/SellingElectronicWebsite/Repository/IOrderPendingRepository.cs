﻿using SellingElectronicWebsite.Entities;
using SellingElectronicWebsite.Model;
using SellingElectronicWebsite.ViewModel;

namespace SellingElectronicWebsite.Repository
{
    public interface IOrderPendingRepository
    {
        Task<List<OrderPendingVM>> GetAll(string status, string sortBy);
        Task<List<OrderPendingVM>> GetByPage(string status, int pageIndex, int pageSize, string sortBy);
        Task<OrderPendingVM> GetById(int id);
        Task<bool> Add(OrderPendingModel model);
        Task<bool> UpdateStatus(string status, int idOrderPending, int idEmployee);
        Task<bool> Cancel(int id);
    }
}
