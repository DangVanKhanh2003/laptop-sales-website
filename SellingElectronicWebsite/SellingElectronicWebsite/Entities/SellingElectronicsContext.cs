using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace SellingElectronicWebsite.Entities;

public partial class SellingElectronicsContext : DbContext
{
    public SellingElectronicsContext()
    {
    }

    public SellingElectronicsContext(DbContextOptions<SellingElectronicsContext> options)
        : base(options)
    {
    }

    public virtual DbSet<AccountCustomer> AccountCustomers { get; set; }

    public virtual DbSet<AccountEmp> AccountEmps { get; set; }

    public virtual DbSet<Address> Addresses { get; set; }

    public virtual DbSet<AddressCustomer> AddressCustomers { get; set; }

    public virtual DbSet<Category> Categories { get; set; }

    public virtual DbSet<Color> Colors { get; set; }

    public virtual DbSet<Comment> Comments { get; set; }

    public virtual DbSet<Customer> Customers { get; set; }

    public virtual DbSet<Department> Departments { get; set; }

    public virtual DbSet<Employee> Employees { get; set; }

    public virtual DbSet<Image> Images { get; set; }

    public virtual DbSet<ImageProduct> ImageProducts { get; set; }

    public virtual DbSet<ImagesSave> ImagesSaves { get; set; }

    public virtual DbSet<Message> Messages { get; set; }

    public virtual DbSet<Order> Orders { get; set; }

    public virtual DbSet<OrderPending> OrderPendings { get; set; }

    public virtual DbSet<Position> Positions { get; set; }

    public virtual DbSet<Product> Products { get; set; }

    public virtual DbSet<ProductDetail> ProductDetails { get; set; }

    public virtual DbSet<ProductOrder> ProductOrders { get; set; }

    public virtual DbSet<ProductOrderPending> ProductOrderPendings { get; set; }

    public virtual DbSet<ProductSpecifiaction> ProductSpecifiactions { get; set; }

    public virtual DbSet<Rating> Ratings { get; set; }

    public virtual DbSet<RefreshTokenCustomer> RefreshTokenCustomers { get; set; }

    public virtual DbSet<RefreshTokenEmployee> RefreshTokenEmployees { get; set; }

    public virtual DbSet<Role> Roles { get; set; }

    public virtual DbSet<Sale> Sales { get; set; }

    public virtual DbSet<ShoppingCart> ShoppingCarts { get; set; }

    public virtual DbSet<Store> Stores { get; set; }

    public virtual DbSet<StoreImport> StoreImports { get; set; }

    public virtual DbSet<StoresProduct> StoresProducts { get; set; }

    public virtual DbSet<TypeAccount> TypeAccounts { get; set; }

    public virtual DbSet<Warehouse> Warehouses { get; set; }

    public virtual DbSet<WarehousesExport> WarehousesExports { get; set; }

    public virtual DbSet<WarehousesExportProduct> WarehousesExportProducts { get; set; }

    public virtual DbSet<WarehousesImport> WarehousesImports { get; set; }

    public virtual DbSet<WarehousesImportProduct> WarehousesImportProducts { get; set; }

    public virtual DbSet<WarehousesProduct> WarehousesProducts { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Data Source=DANGVANKHANH\\SQLEXPRESS;Initial Catalog=SellingElectronics;Persist Security Info=True;User Id=1;Password=1;Integrated Security=false;Trust Server Certificate=True");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<AccountCustomer>(entity =>
        {
            entity.HasKey(e => e.AccCustomerId);

            entity.ToTable("AccountCustomer", "AccountSchema");

            entity.Property(e => e.AccCustomerId).HasDefaultValueSql("(newid())");
            entity.Property(e => e.Email)
                .HasMaxLength(200)
                .IsUnicode(false)
                .HasColumnName("email");
            entity.Property(e => e.Password).IsUnicode(false);

            entity.HasOne(d => d.Customer).WithMany(p => p.AccountCustomers)
                .HasForeignKey(d => d.CustomerId)
                .HasConstraintName("FK_AccountCustomer_Customer");
        });

        modelBuilder.Entity<AccountEmp>(entity =>
        {
            entity.HasKey(e => e.AccEmpId);

            entity.ToTable("AccountEmp", "AccountSchema");

            entity.Property(e => e.AccEmpId).HasDefaultValueSql("(newid())");
            entity.Property(e => e.Email)
                .HasMaxLength(200)
                .IsUnicode(false);
            entity.Property(e => e.Password).IsUnicode(false);

            entity.HasOne(d => d.Employee).WithMany(p => p.AccountEmps)
                .HasForeignKey(d => d.EmployeeId)
                .HasConstraintName("FK_AccountCustomer_Employee");

            entity.HasOne(d => d.TypeAcc).WithMany(p => p.AccountEmps)
                .HasForeignKey(d => d.TypeAccId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_AccountEmp_TypeAccount");
        });

        modelBuilder.Entity<Address>(entity =>
        {
            entity.ToTable("Address");

            entity.Property(e => e.Commune).HasMaxLength(100);
            entity.Property(e => e.District).HasMaxLength(100);
            entity.Property(e => e.NumberHouse).HasMaxLength(50);
            entity.Property(e => e.Province).HasMaxLength(100);
            entity.Property(e => e.Street).HasMaxLength(100);
        });

        modelBuilder.Entity<AddressCustomer>(entity =>
        {
            entity.HasKey(e => e.AddressCusId).HasName("PK_Address");

            entity.ToTable("AddressCustomer", "UserSchema");

            entity.Property(e => e.Commune).HasMaxLength(100);
            entity.Property(e => e.District).HasMaxLength(100);
            entity.Property(e => e.NumberHouse).HasMaxLength(50);
            entity.Property(e => e.PhoneNumber).HasMaxLength(12);
            entity.Property(e => e.Province).HasMaxLength(100);
            entity.Property(e => e.Street).HasMaxLength(100);

            entity.HasOne(d => d.Customer).WithMany(p => p.AddressCustomers)
                .HasForeignKey(d => d.CustomerId)
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("FK_AddressCustomer_Customer");
        });

        modelBuilder.Entity<Category>(entity =>
        {
            entity.HasKey(e => e.CategoryId).HasName("PK_Category");

            entity.ToTable("Categories", "ProductSchema");

            entity.HasIndex(e => e.CategoryName, "UQ__Categori__8517B2E03DAFC46E").IsUnique();

            entity.Property(e => e.CategoryIcon).HasMaxLength(200);
            entity.Property(e => e.CategoryName).HasMaxLength(200);
        });

        modelBuilder.Entity<Color>(entity =>
        {
            entity.ToTable("Color", "ProductSchema");

            entity.HasIndex(e => e.ColorName, "UQ_ColorName").IsUnique();

            entity.Property(e => e.ColorName).HasMaxLength(255);
        });

        modelBuilder.Entity<Comment>(entity =>
        {
            entity.ToTable("Comments", "ProductSchema");

            entity.Property(e => e.CommentDate)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");

            entity.HasOne(d => d.Customer).WithMany(p => p.CommentCustomers)
                .HasForeignKey(d => d.CustomerId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_Comments_Customers");

            entity.HasOne(d => d.Parent).WithMany(p => p.InverseParent)
                .HasForeignKey(d => d.ParentId)
                .HasConstraintName("FK_Comments_Comments");

            entity.HasOne(d => d.Product).WithMany(p => p.Comments)
                .HasForeignKey(d => d.ProductId)
                .HasConstraintName("FK_Comments_Products");

            entity.HasOne(d => d.ToCustomer).WithMany(p => p.CommentToCustomers)
                .HasForeignKey(d => d.ToCustomerId)
                .HasConstraintName("FK_Comments_Customer_replyToId");
        });

        modelBuilder.Entity<Customer>(entity =>
        {
            entity.HasKey(e => e.CustomerId).HasName("PK_Customer");

            entity.ToTable("Customers", "UserSchema");

            entity.Property(e => e.FullName).HasMaxLength(150);
            entity.Property(e => e.PhoneNumber)
                .HasMaxLength(12)
                .IsUnicode(false);

            entity.HasOne(d => d.Address).WithMany(p => p.Customers)
                .HasForeignKey(d => d.AddressId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_Customer_Address");
        });

        modelBuilder.Entity<Department>(entity =>
        {
            entity.ToTable("Department", "UserSchema");

            entity.HasIndex(e => e.DepartmentName, "UQ__Departme__D949CC34B113796B").IsUnique();

            entity.Property(e => e.DepartmentName).HasMaxLength(150);
        });

        modelBuilder.Entity<Employee>(entity =>
        {
            entity.HasKey(e => e.EmployeeId).HasName("PK_Employee");

            entity.ToTable("Employees", "UserSchema");

            entity.Property(e => e.Email)
                .HasMaxLength(150)
                .IsUnicode(false);
            entity.Property(e => e.FullName).HasMaxLength(150);
            entity.Property(e => e.PhoneNumber)
                .HasMaxLength(12)
                .IsUnicode(false);

            entity.HasOne(d => d.Address).WithMany(p => p.EmployeeAddresses)
                .HasForeignKey(d => d.AddressId)
                .HasConstraintName("FK_Employee_Address");

            entity.HasOne(d => d.Position).WithMany(p => p.EmployeePositions)
                .HasForeignKey(d => d.PositionId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_Employee_Position");

            entity.HasOne(d => d.Store).WithMany(p => p.Employees)
                .HasForeignKey(d => d.StoreId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_Employee_Store");
        });

        modelBuilder.Entity<Image>(entity =>
        {
            entity.Property(e => e.ImagePath).HasMaxLength(500);

            entity.HasOne(d => d.Rating).WithMany(p => p.Images)
                .HasForeignKey(d => d.RatingId)
                .HasConstraintName("FK_Images_Ratings");
        });

        modelBuilder.Entity<ImageProduct>(entity =>
        {
            entity.HasKey(e => e.ImgId);

            entity.ToTable("ImageProduct", "ProductSchema");

            entity.Property(e => e.ImgLink)
                .HasMaxLength(2000)
                .IsUnicode(false);

            entity.HasOne(d => d.Color).WithMany(p => p.ImageProducts)
                .HasForeignKey(d => d.ColorId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_ImageProduct_Color");

            entity.HasOne(d => d.Product).WithMany(p => p.ImageProducts)
                .HasForeignKey(d => d.ProductId)
                .HasConstraintName("FK_ImageProduct_Products");
        });

        modelBuilder.Entity<ImagesSave>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__ImagesSa__3214EC073FDA9B2F");

            entity.ToTable("ImagesSave");

            entity.Property(e => e.FileExtension).HasMaxLength(10);
            entity.Property(e => e.FileName).HasMaxLength(255);
        });

        modelBuilder.Entity<Message>(entity =>
        {
            entity.HasKey(e => e.MessagesId).HasName("PK_Chats");

            entity.ToTable("Messages", "ChatingSchema");

            entity.Property(e => e.ChatTime)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.PersonSend).HasMaxLength(10);

            entity.HasOne(d => d.Customer).WithMany(p => p.Messages)
                .HasForeignKey(d => d.CustomerId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_Chats_Customers");

            entity.HasOne(d => d.Employee).WithMany(p => p.Messages)
                .HasForeignKey(d => d.EmployeeId)
                .HasConstraintName("FK_Chats_Employees");
        });

        modelBuilder.Entity<Order>(entity =>
        {
            entity.ToTable("Orders", "OrderSchema");

            entity.Property(e => e.DateExport).HasColumnType("datetime");
            entity.Property(e => e.OdertDate).HasColumnType("datetime");
            entity.Property(e => e.OrderType).HasMaxLength(10);
            entity.Property(e => e.Status)
                .HasMaxLength(20)
                .IsUnicode(false);

            entity.HasOne(d => d.Customer).WithMany(p => p.Orders)
                .HasForeignKey(d => d.CustomerId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_Orders_Customers");

            entity.HasOne(d => d.Employee).WithMany(p => p.Orders)
                .HasForeignKey(d => d.EmployeeId)
                .HasConstraintName("FK_Orders_Employees");

            entity.HasOne(d => d.OrderPending).WithMany(p => p.Orders)
                .HasForeignKey(d => d.OrderPendingId)
                .HasConstraintName("FK_Orders_OrderPending");

            entity.HasOne(d => d.Store).WithMany(p => p.Orders)
                .HasForeignKey(d => d.StoreId)
                .HasConstraintName("FK_Orders_Store");
        });

        modelBuilder.Entity<OrderPending>(entity =>
        {
            entity.ToTable("OrderPending", "OrderSchema");

            entity.Property(e => e.OdertDate)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.Status)
                .HasMaxLength(50)
                .IsUnicode(false);

            entity.HasOne(d => d.Customer).WithMany(p => p.OrderPendings)
                .HasForeignKey(d => d.CustomerId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_OrderPending_Customers");

            entity.HasOne(d => d.Employee).WithMany(p => p.OrderPendings)
                .HasForeignKey(d => d.EmployeeId)
                .HasConstraintName("FK_OrderPending_Employees");
        });

        modelBuilder.Entity<Position>(entity =>
        {
            entity.ToTable("Position", "UserSchema");

            entity.HasIndex(e => e.PositionName, "UQ__Position__E46AEF426792C4DD").IsUnique();

            entity.Property(e => e.PositionName).HasMaxLength(150);

            entity.HasOne(d => d.Department).WithMany(p => p.Positions)
                .HasForeignKey(d => d.DepartmentId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_Position_Department");
        });

        modelBuilder.Entity<Product>(entity =>
        {
            entity.ToTable("Products", "ProductSchema");

            entity.HasIndex(e => e.ProductName, "UQ__Products__DD5A978AE39EFAE3").IsUnique();

            entity.Property(e => e.Brand).HasMaxLength(200);
            entity.Property(e => e.MainImg)
                .HasMaxLength(500)
                .IsUnicode(false);
            entity.Property(e => e.Price).HasColumnType("money");
            entity.Property(e => e.ProductName).HasMaxLength(200);
            entity.Property(e => e.Series).HasMaxLength(200);

            entity.HasOne(d => d.Category).WithMany(p => p.Products)
                .HasForeignKey(d => d.CategoryId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_Products_Categories");
        });

        modelBuilder.Entity<ProductDetail>(entity =>
        {
            entity.HasKey(e => e.DetailsId);

            entity.ToTable("ProductDetails", "ProductSchema");

            entity.Property(e => e.DetailsId).HasColumnName("DetailsID");
            entity.Property(e => e.CreatedAt)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.ProductId).HasColumnName("ProductID");

            entity.HasOne(d => d.Product).WithMany(p => p.ProductDetails)
                .HasForeignKey(d => d.ProductId)
                .HasConstraintName("FK_ProductDetails_Product");
        });

        modelBuilder.Entity<ProductOrder>(entity =>
        {
            entity.ToTable("ProductOrder", "OrderSchema");

            entity.Property(e => e.ColorId).HasColumnName("colorId");
            entity.Property(e => e.UntilPrice).HasColumnType("money");

            entity.HasOne(d => d.Color).WithMany(p => p.ProductOrders)
                .HasForeignKey(d => d.ColorId)
                .HasConstraintName("fk_ProductOrder_color");

            entity.HasOne(d => d.Order).WithMany(p => p.ProductOrders)
                .HasForeignKey(d => d.OrderId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_ProductOrder_Orders");

            entity.HasOne(d => d.Product).WithMany(p => p.ProductOrders)
                .HasForeignKey(d => d.ProductId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_ProductOrder_Products");
        });

        modelBuilder.Entity<ProductOrderPending>(entity =>
        {
            entity.ToTable("ProductOrderPending", "OrderSchema");

            entity.Property(e => e.ColorId).HasColumnName("colorId");

            entity.HasOne(d => d.Color).WithMany(p => p.ProductOrderPendings)
                .HasForeignKey(d => d.ColorId)
                .HasConstraintName("fk_ProductOrderPending_color");

            entity.HasOne(d => d.OrderPending).WithMany(p => p.ProductOrderPendings)
                .HasForeignKey(d => d.OrderPendingId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_ProductOrderPending_Customers");

            entity.HasOne(d => d.Product).WithMany(p => p.ProductOrderPendings)
                .HasForeignKey(d => d.ProductId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_ProductOrderPending_Products");
        });

        modelBuilder.Entity<ProductSpecifiaction>(entity =>
        {
            entity.HasKey(e => e.SpecifiactionsId);

            entity.ToTable("ProductSpecifiactions", "ProductSchema");

            entity.Property(e => e.Description).HasMaxLength(1500);
            entity.Property(e => e.SpecType).HasMaxLength(300);

            entity.HasOne(d => d.Product).WithMany(p => p.ProductSpecifiactions)
                .HasForeignKey(d => d.ProductId)
                .HasConstraintName("FK_ProductSpecifiactions_Products");
        });

        modelBuilder.Entity<Rating>(entity =>
        {
            entity.ToTable("Ratings", "ProductSchema");

            entity.Property(e => e.RatingDate)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");

            entity.HasOne(d => d.Customer).WithMany(p => p.Ratings)
                .HasForeignKey(d => d.CustomerId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_Ratings_Customers");

            entity.HasOne(d => d.Product).WithMany(p => p.Ratings)
                .HasForeignKey(d => d.ProductId)
                .HasConstraintName("FK_Ratings_Products");
        });

        modelBuilder.Entity<RefreshTokenCustomer>(entity =>
        {
            entity.HasKey(e => e.RefreshTokenCustomerId).HasName("PK__RefreshT__EB55C1121B83DBB5");

            entity.ToTable("RefreshTokenCustomer", "AccountSchema");

            entity.Property(e => e.RefreshTokenCustomerId).HasDefaultValueSql("(newid())");
            entity.Property(e => e.Email)
                .HasMaxLength(150)
                .IsUnicode(false)
                .HasColumnName("email");
            entity.Property(e => e.ExpiredAt).HasColumnType("datetime");
            entity.Property(e => e.IssuedAt).HasColumnType("datetime");
            entity.Property(e => e.JwtId)
                .HasMaxLength(200)
                .IsUnicode(false);
            entity.Property(e => e.Token)
                .HasMaxLength(1000)
                .IsUnicode(false);

            entity.HasOne(d => d.Customer).WithMany(p => p.RefreshTokenCustomers)
                .HasForeignKey(d => d.CustomerId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_RefreshTokenCustomer_Customer");
        });

        modelBuilder.Entity<RefreshTokenEmployee>(entity =>
        {
            entity.HasKey(e => e.RefreshTokenEmployeeId).HasName("PK__RefreshT__01865F84701F24CD");

            entity.ToTable("RefreshTokenEmployee", "AccountSchema");

            entity.Property(e => e.RefreshTokenEmployeeId).HasDefaultValueSql("(newid())");
            entity.Property(e => e.ExpiredAt).HasColumnType("datetime");
            entity.Property(e => e.IssuedAt).HasColumnType("datetime");
            entity.Property(e => e.JwtId)
                .HasMaxLength(200)
                .IsUnicode(false);
            entity.Property(e => e.Token)
                .HasMaxLength(1000)
                .IsUnicode(false);

            entity.HasOne(d => d.AccEmp).WithMany(p => p.RefreshTokenEmployees)
                .HasForeignKey(d => d.AccEmpId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_RefreshTokenEmployee_AccountEmp");
        });

        modelBuilder.Entity<Role>(entity =>
        {
            entity.HasKey(e => e.RolesId).HasName("PK_ROLES");

            entity.ToTable("Roles", "AccountSchema");

            entity.HasIndex(e => e.RolesName, "UQ__Roles__CD1DC953596AC574").IsUnique();

            entity.Property(e => e.RolesId).HasDefaultValueSql("(newid())");
            entity.Property(e => e.RolesName)
                .HasMaxLength(100)
                .IsUnicode(false);
        });

        modelBuilder.Entity<Sale>(entity =>
        {
            entity.ToTable("Sales", "SalesSchema");

            entity.Property(e => e.EndAt).HasColumnType("datetime");
            entity.Property(e => e.StartAt).HasColumnType("datetime");

            entity.HasOne(d => d.Product).WithMany(p => p.Sales)
                .HasForeignKey(d => d.ProductId)
                .HasConstraintName("FK_Sales_Products");
        });

        modelBuilder.Entity<ShoppingCart>(entity =>
        {
            entity.ToTable("ShoppingCart", "OrderSchema");

            entity.HasOne(d => d.Color).WithMany(p => p.ShoppingCarts)
                .HasForeignKey(d => d.ColorId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_ShoppingCart_Color");

            entity.HasOne(d => d.Customer).WithMany(p => p.ShoppingCarts)
                .HasForeignKey(d => d.CustomerId)
                .HasConstraintName("FK_ShoppingCart_Customers");

            entity.HasOne(d => d.Product).WithMany(p => p.ShoppingCarts)
                .HasForeignKey(d => d.ProductId)
                .HasConstraintName("FK_ShoppingCart_Products");
        });

        modelBuilder.Entity<Store>(entity =>
        {
            entity.HasKey(e => e.StoreId).HasName("PK_Store");

            entity.ToTable("Stores", "StoreSchema");

            entity.HasIndex(e => e.StoreName, "UQ__Stores__520DB6525043250F").IsUnique();

            entity.Property(e => e.StoreName).HasMaxLength(200);

            entity.HasOne(d => d.Address).WithMany(p => p.Stores)
                .HasForeignKey(d => d.AddressId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_Store_Address");
        });

        modelBuilder.Entity<StoreImport>(entity =>
        {
            entity.ToTable("StoreImport", "StoreSchema");

            entity.Property(e => e.EmployeeId).HasColumnName("employeeId");
            entity.Property(e => e.TimeAt)
                .HasColumnType("datetime")
                .HasColumnName("timeAt");

            entity.HasOne(d => d.Employee).WithMany(p => p.StoreImports)
                .HasForeignKey(d => d.EmployeeId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_StoreImport_Employee");

            entity.HasOne(d => d.Store).WithMany(p => p.StoreImports)
                .HasForeignKey(d => d.StoreId)
                .HasConstraintName("FK_StoreImport_Stores");

            entity.HasOne(d => d.WarehousesExport).WithMany(p => p.StoreImports)
                .HasForeignKey(d => d.WarehousesExportId)
                .HasConstraintName("FK_StoreImport_WarehousesExport");
        });

        modelBuilder.Entity<StoresProduct>(entity =>
        {
            entity.ToTable("StoresProduct", "StoreSchema");

            entity.HasIndex(e => new { e.StoreId, e.ProductId, e.ColorId }, "Unique_StoreIdId_ProductId").IsUnique();

            entity.HasOne(d => d.Color).WithMany(p => p.StoresProducts)
                .HasForeignKey(d => d.ColorId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_StoresProduct_Color");

            entity.HasOne(d => d.Product).WithMany(p => p.StoresProducts)
                .HasForeignKey(d => d.ProductId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_StoresProduct_Products");

            entity.HasOne(d => d.Store).WithMany(p => p.StoresProducts)
                .HasForeignKey(d => d.StoreId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_StoresProduct_Stores");
        });

        modelBuilder.Entity<TypeAccount>(entity =>
        {
            entity.HasKey(e => e.TypeAccId);

            entity.ToTable("TypeAccount", "AccountSchema");

            entity.HasIndex(e => e.TypeAccName, "UQ__TypeAcco__DBF27857B4418949").IsUnique();

            entity.Property(e => e.TypeAccId).HasDefaultValueSql("(newid())");
            entity.Property(e => e.TypeAccName)
                .HasMaxLength(100)
                .IsUnicode(false);

            entity.HasMany(d => d.Roles).WithMany(p => p.TypeAccs)
                .UsingEntity<Dictionary<string, object>>(
                    "TypeAccRole",
                    r => r.HasOne<Role>().WithMany()
                        .HasForeignKey("RolesId")
                        .HasConstraintName("FK_TypeAccRoles_ROLES"),
                    l => l.HasOne<TypeAccount>().WithMany()
                        .HasForeignKey("TypeAccId")
                        .HasConstraintName("FK_TypeAccRoles_TypeAccount"),
                    j =>
                    {
                        j.HasKey("TypeAccId", "RolesId");
                        j.ToTable("TypeAccRoles", "AccountSchema");
                    });
        });

        modelBuilder.Entity<Warehouse>(entity =>
        {
            entity.HasKey(e => e.WarehouseId).HasName("PK_Warehouse");

            entity.ToTable("Warehouses", "StoreSchema");

            entity.HasIndex(e => e.WarehouseName, "UQ__Warehous__180C89D9E837CB4E").IsUnique();

            entity.Property(e => e.WarehouseName).HasMaxLength(200);

            entity.HasOne(d => d.Address).WithMany(p => p.Warehouses)
                .HasForeignKey(d => d.AddressId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_WarehouseId_Address");
        });

        modelBuilder.Entity<WarehousesExport>(entity =>
        {
            entity.ToTable("WarehousesExport", "StoreSchema");

            entity.Property(e => e.EmployeeId).HasColumnName("employeeId");
            entity.Property(e => e.TimeAt)
                .HasColumnType("datetime")
                .HasColumnName("timeAt");

            entity.HasOne(d => d.Employee).WithMany(p => p.WarehousesExports)
                .HasForeignKey(d => d.EmployeeId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_WarehousesExport_Employee");

            entity.HasOne(d => d.Store).WithMany(p => p.WarehousesExports)
                .HasForeignKey(d => d.StoreId)
                .HasConstraintName("FK_WarehousesExport_Stores");

            entity.HasOne(d => d.Warehouse).WithMany(p => p.WarehousesExports)
                .HasForeignKey(d => d.WarehouseId)
                .HasConstraintName("FK_WarehousesExport_Warehouses");
        });

        modelBuilder.Entity<WarehousesExportProduct>(entity =>
        {
            entity.ToTable("WarehousesExport_product", "StoreSchema");

            entity.Property(e => e.WarehousesExportProductId).HasColumnName("WarehousesExport_productId");
            entity.Property(e => e.Amount).HasColumnName("amount");

            entity.HasOne(d => d.Product).WithMany(p => p.WarehousesExportProducts)
                .HasForeignKey(d => d.ProductId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_WarehousesExport_product_Products");

            entity.HasOne(d => d.WarehousesExport).WithMany(p => p.WarehousesExportProducts)
                .HasForeignKey(d => d.WarehousesExportId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_WarehousesExport_product_WarehousesExport");
        });

        modelBuilder.Entity<WarehousesImport>(entity =>
        {
            entity.ToTable("WarehousesImport", "StoreSchema");

            entity.Property(e => e.EmployeeId).HasColumnName("employeeId");
            entity.Property(e => e.TimeAt)
                .HasColumnType("datetime")
                .HasColumnName("timeAt");

            entity.HasOne(d => d.Employee).WithMany(p => p.WarehousesImports)
                .HasForeignKey(d => d.EmployeeId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_WarehousesImport_Employee");

            entity.HasOne(d => d.Warehouse).WithMany(p => p.WarehousesImports)
                .HasForeignKey(d => d.WarehouseId)
                .HasConstraintName("FK_WarehousesImport_Warehouses");
        });

        modelBuilder.Entity<WarehousesImportProduct>(entity =>
        {
            entity.ToTable("WarehousesImport_product", "StoreSchema");

            entity.Property(e => e.WarehousesImportProductId).HasColumnName("WarehousesImport_productId");
            entity.Property(e => e.Amount).HasColumnName("amount");

            entity.HasOne(d => d.Product).WithMany(p => p.WarehousesImportProducts)
                .HasForeignKey(d => d.ProductId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_WarehousesImport_product_Products");

            entity.HasOne(d => d.WarehousesImport).WithMany(p => p.WarehousesImportProducts)
                .HasForeignKey(d => d.WarehousesImportId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK_WarehousesImport_product_WarehousesImport");
        });

        modelBuilder.Entity<WarehousesProduct>(entity =>
        {
            entity.ToTable("WarehousesProduct", "StoreSchema");

            entity.HasIndex(e => new { e.WarehouseId, e.ProductId, e.ColorId }, "Unique_WarehouseId_ProductId").IsUnique();

            entity.HasOne(d => d.Color).WithMany(p => p.WarehousesProducts)
                .HasForeignKey(d => d.ColorId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_WarehousesProduct_Color");

            entity.HasOne(d => d.Product).WithMany(p => p.WarehousesProducts)
                .HasForeignKey(d => d.ProductId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_WarehousesProduct_Products");

            entity.HasOne(d => d.Warehouse).WithMany(p => p.WarehousesProducts)
                .HasForeignKey(d => d.WarehouseId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_WarehousesProduct_Warehouses");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
