{ ... }:
{
	homeModules.permissions = { lib, ... }:
	{
		home.activation = {
		  checkAppManagementPermission = lib.mkForce "";
		};
	};
}
