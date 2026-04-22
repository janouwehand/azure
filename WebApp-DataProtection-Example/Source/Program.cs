using Azure.Identity;
using Microsoft.AspNetCore.DataProtection;

var builder = WebApplication.CreateBuilder(args);

var blobUri = new Uri("https://jlostor.blob.core.windows.net/dataprotection/keys.xml");
var keyIdentifier = new Uri("https://jlo-keyvault.vault.azure.net/keys/dataprotection");
var credential = new DefaultAzureCredential();

builder.Services.AddDataProtection()
    .SetApplicationName("jlo-webapp1")
    .PersistKeysToAzureBlobStorage(blobUri, credential)
    .ProtectKeysWithAzureKeyVault(keyIdentifier, credential);

var app = builder.Build();

var protector = app.Services
    .GetRequiredService<IDataProtectionProvider>()
    .CreateProtector("demo.v1");

app.MapGet("/", () => "OK");

app.MapGet("/protect/{value}", (string value) =>
{
    var protectedValue = protector.Protect(value);
    return Results.Text(protectedValue);
});

app.MapGet("/unprotect/{value}", (string value) =>
{
    try
    {
        var unprotectedValue = protector.Unprotect(value);
        return Results.Text(unprotectedValue);
    }
    catch (Exception ex)
    {
        return Results.Problem(
            title: "Unprotect failed",
            detail: ex.ToString(),
            statusCode: 500);
    }
});

app.Run();

