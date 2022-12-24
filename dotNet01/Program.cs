var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddRazorPages();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.MapGet("/sai", () => "This is the end point for the page!!(TESTING)");
app.MapGet("/mysong", () => Results.Redirect("Song"));
// app.MapGet("/Mysong", () => Console.Write("Song page"));
app.UseRouting();

app.UseHttpsRedirection();
app.UseStaticFiles();
app.UseRouting();

app.UseAuthorization();

app.MapRazorPages();

app.Run();




//app.MapGet("/mysong", () => Results.File("Index.cshtml"));

// var proxyClient = new HttpClient();
// app.MapGet("/hi", async () => 
// {
//     var stream = await proxyClient.GetStreamAsync("www.google.com");
//     // Proxy the response as JSON
//     return Results.Stream(stream, "/hi");
// });