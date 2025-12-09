package com.testing.system.data.repository;

import com.testing.system.data.entity.CustomerEntity;
import org.springframework.data.repository.CrudRepository;

import java.util.UUID;

public interface CustomerRepository extends CrudRepository<CustomerEntity, UUID> {
  CustomerEntity findByEmailAddress(String emailAddress);
}