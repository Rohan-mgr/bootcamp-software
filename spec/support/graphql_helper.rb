module GraphQLHelper
  def execute_graphql(query, variables: {}, context: {})
    FleetpandaPetroleumSoftwareSchema.execute(
      query,
      variables: variables,
      context: context
    )
  end
end
