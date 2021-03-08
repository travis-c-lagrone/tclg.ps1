<#
.Synopsis
	Build script <https://github.com/nightroman/Invoke-Build>
#>

param(
	[ValidateSet('Debug', 'Release')]
	[string]$Configuration = 'Release'
)

function Build-PSObjectExtensionMethods ([string] $CSharpFile) {
	# TODO Get public extension methods from file.
	# TODO Generate (overwrite) another source file that implements PSObject -typed overloads of those methods.
}

function Build-CodeMembersTypeDataFile ([string] $PSCodeMethodsFile) {
	# TODO Extract the relevant methods therefrom.
	# TODO generate String.Code.types.ps1xml
}

# Synopsis: Build project.
task build {
	exec { dotnet build -c $Configuration }
}

# Synopsis: Remove files.
task clean {
	remove bin, obj
}

# Synopsis: Default task.
task . build
