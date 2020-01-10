objects.Set(3033, "Chop down", function(user, tree)
	user:Act("tut_woodcutting", { tree = tree })
end)